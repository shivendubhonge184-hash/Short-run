<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    // ---------- AUTH ----------
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("studentLogin.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("user_id");

    // ---------- DB ----------
    Connection con = null;
    PreparedStatement ps2 = null;
    ResultSet rs2 = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/aptitude",
                "root",
                "28072006");

        // ---------- CATEGORY ----------
       
        Integer categoryId = (Integer)session.getAttribute("category_id");

        String categoryParam = request.getParameter("category_id");

        if(categoryParam != null){

            int newCategoryId = Integer.parseInt(categoryParam);

            if(categoryId == null || categoryId != newCategoryId){

                categoryId = newCategoryId;

                session.setAttribute("category_id", categoryId);

                session.removeAttribute("questionIds");
                session.removeAttribute("answers");
                session.removeAttribute("currentQuestion");
                session.removeAttribute("quizStartTime");

            }

        }

        if(categoryId == null){

            response.sendRedirect("aptitude.jsp");

            return;

        }
        // ---------- LOAD QUESTIONS ONCE ----------
        ArrayList<Integer> questionIds =
                (ArrayList<Integer>) session.getAttribute("questionIds");

        if (questionIds == null) {
            questionIds = new ArrayList<Integer>();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT question_id FROM questions WHERE category_id=? ORDER BY RAND() LIMIT 10");
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                questionIds.add(rs.getInt("question_id"));
            }
            rs.close();
            ps.close();

            session.setAttribute("questionIds", questionIds);
            session.setAttribute("answers", new HashMap<Integer, String>());
            session.setAttribute("currentQuestion", 0);
            session.setAttribute("quizStartTime", System.currentTimeMillis());
        }

        if (questionIds.isEmpty()) {
    %>
        <h2 style="text-align:center;margin-top:80px;font-family:sans-serif;">
            No questions available for this category.
            <br><a href="dashboard.jsp">Back to Dashboard</a>
        </h2>
    <%
            return;
        }

        HashMap<Integer, String> answers =
                (HashMap<Integer, String>) session.getAttribute("answers");

        int current = (Integer) session.getAttribute("currentQuestion");

        // ---------- HANDLE POST (save answer BEFORE navigation) ----------
        if ("POST".equalsIgnoreCase(request.getMethod())) {

            // 1) Always save the answer first if provided
            String qidStr = request.getParameter("qid");
            String ans    = request.getParameter("answer");
            if (qidStr != null) {
                int qid = Integer.parseInt(qidStr);
                if (ans != null && !ans.isEmpty()) {
                    answers.put(qid, ans);
                } else {
                    // user cleared selection -> remove
                    answers.remove(qid);
                }
                session.setAttribute("answers", answers);
            }

            // 2) Then handle navigation
            String action = request.getParameter("action");
            String gotoStr = request.getParameter("goto");

            if ("next".equals(action) && current < questionIds.size() - 1) {
                current++;
            } else if ("previous".equals(action) && current > 0) {
                current--;
            } else if ("goto".equals(action) && gotoStr != null) {
                int g = Integer.parseInt(gotoStr);
                if (g >= 0 && g < questionIds.size()) current = g;
            } else if ("finish".equals(action)) {
                session.setAttribute("currentQuestion", current);
                response.sendRedirect("submitQuiz.jsp");
                return;
            }

            session.setAttribute("currentQuestion", current);

            // Redirect (PRG pattern) so refresh doesn't resubmit
            response.sendRedirect("quiz.jsp");
            return;
        }

        // ---------- LOAD CURRENT QUESTION ----------
        int questionId = questionIds.get(current);
        ps2 = con.prepareStatement("SELECT * FROM questions WHERE question_id=?");
        ps2.setInt(1, questionId);
        rs2 = ps2.executeQuery();
        if (!rs2.next()) {
            out.println("Question not found.");
            return;
        }

        String qText  = rs2.getString("question_text");
        String optA   = rs2.getString("option_a");
        String optB   = rs2.getString("option_b");
        String optC   = rs2.getString("option_c");
        String optD   = rs2.getString("option_d");

        String selectedAnswer = answers.get(questionId);
        if (selectedAnswer == null) selectedAnswer = "";

        // Timer: server-side remaining seconds (15 minutes total)
        long startTime = (Long) session.getAttribute("quizStartTime");
        long elapsed   = (System.currentTimeMillis() - startTime) / 1000;
        long remaining = 900 - elapsed;
        if (remaining < 0) remaining = 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Online Assessment</title>
    <meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Poppins',sans-serif; }
        body { background:#eef2ff; }
        .header {
            height:80px; background:white;
            display:flex; justify-content:space-between; align-items:center;
            padding:0 50px; box-shadow:0 5px 20px rgba(0,0,0,.08);
        }
        .logo { font-size:28px; font-weight:700; color:#2563eb; }
        .timer { font-size:24px; font-weight:700; color:#dc2626; }
        .container {
            max-width:1200px; margin:40px auto; padding:0 20px;
            display:grid; grid-template-columns:3fr 1fr; gap:30px;
        }
        .quiz {
            background:white; padding:40px;
            border-radius:20px; box-shadow:0 15px 40px rgba(0,0,0,.08);
        }
        .progress {
            height:12px; background:#e5e7eb;
            border-radius:20px; overflow:hidden; margin-bottom:35px;
        }
        .progress-bar {
            height:100%; background:#2563eb;
            width:<%= ((current + 1) * 100) / questionIds.size() %>%;
            transition:width .4s;
        }
        .question-number { font-size:18px; color:#6b7280; margin-bottom:15px; }
        .question { font-size:26px; font-weight:600; line-height:42px; margin-bottom:40px; }
        .option {
            margin-bottom:18px; padding:18px;
            border:2px solid #e5e7eb; border-radius:12px;
            cursor:pointer; transition:.25s;
        }
        .option:hover { border-color:#2563eb; background:#eff6ff; }
        .option label { display:flex; align-items:center; cursor:pointer; width:100%; }
        .option input { margin-right:12px; transform:scale(1.3); }
        .btn {
            padding:14px 35px; border:none; color:white;
            border-radius:10px; cursor:pointer; font-size:15px; font-weight:500;
        }
        .btn-prev   { background:#64748b; }
        .btn-next   { background:#2563eb; }
        .btn-finish { background:#16a34a; }
        .palette {
            background:white; padding:30px;
            border-radius:20px; box-shadow:0 15px 35px rgba(0,0,0,.08);
            height:fit-content;
        }
        .palette h2 { margin-bottom:25px; font-size:20px; }
        .palette-grid {
            display:grid; grid-template-columns:repeat(5,1fr); gap:12px;
        }
        .p-btn {
            height:48px; width:100%;
            display:flex; justify-content:center; align-items:center;
            border-radius:10px; font-weight:bold; color:white;
            border:none; cursor:pointer; font-size:15px;
        }
        .legend { line-height:35px; margin-top:20px; }
        .legend span {
            display:inline-block; width:18px; height:18px;
            border-radius:5px; margin-right:8px; vertical-align:middle;
        }
    </style>
</head>
<body>

<div class="header">
    <div class="logo">Placement Portal</div>
    <div class="timer" id="timer">--:--</div>
</div>

<div class="container">
    <!-- MAIN QUIZ -->
    <div class="quiz">
        <div class="progress"><div class="progress-bar"></div></div>

        <div class="question-number">
            Question <%= current + 1 %> of <%= questionIds.size() %>
        </div>

        <div class="question"><%= qText %></div>

        <!-- Single form: answer + navigation submitted together -->
        <form method="post" action="quiz.jsp" id="quizForm">
            <input type="hidden" name="qid" value="<%= questionId %>">
            <input type="hidden" name="action" id="actionField" value="next">
            <input type="hidden" name="goto"   id="gotoField"   value="">

            <% String[] letters = {"A","B","C","D"};
               String[] texts   = {optA, optB, optC, optD};
               for (int i = 0; i < 4; i++) {
                   String L = letters[i];
                   String T = texts[i];
            %>
            <div class="option" onclick="document.getElementById('opt<%=L%>').click();">
                <label>
                    <input type="radio" id="opt<%=L%>" name="answer" value="<%=L%>"
                        <%= selectedAnswer.equals(L) ? "checked" : "" %>>
                    <span><b><%=L%>.</b> &nbsp; <%= T %></span>
                </label>
            </div>
            <% } %>

            <div style="display:flex; justify-content:space-between; margin-top:40px;">
                <% if (current > 0) { %>
                    <button type="submit" class="btn btn-prev"
                            onclick="document.getElementById('actionField').value='previous';">
                        &larr; Previous
                    </button>
                <% } else { %>
                    <div></div>
                <% } %>

                <% if (current < questionIds.size() - 1) { %>
                    <button type="submit" class="btn btn-next"
                            onclick="document.getElementById('actionField').value='next';">
                        Next &rarr;
                    </button>
                <% } else { %>
                    <button type="submit" class="btn btn-finish"
                            onclick="return confirmFinish();">
                        Finish Quiz
                    </button>
                <% } %>
            </div>
        </form>
    </div>

    <!-- QUESTION PALETTE -->
    <div class="palette">
        <h2>Question Palette</h2>
        <div class="palette-grid">
            <% for (int i = 0; i < questionIds.size(); i++) {
                   int q = questionIds.get(i);
                   boolean answered = answers.containsKey(q);
                   String color = "#e5e7eb";
                   if (answered) color = "#22c55e";
                   if (i == current) color = "#2563eb";
            %>
                <button type="button" class="p-btn"
                        style="background:<%=color%>;"
                        onclick="gotoQuestion(<%=i%>)">
                    <%= i + 1 %>
                </button>
            <% } %>
        </div>

        <hr style="margin:25px 0;">

        <div class="legend">
            <p><span style="background:#2563eb;"></span> Current Question</p>
            <p><span style="background:#22c55e;"></span> Answered</p>
            <p><span style="background:#e5e7eb;"></span> Not Answered</p>
        </div>

        <button type="button" class="btn btn-finish"
                style="width:100%; margin-top:20px;"
                onclick="finishQuiz();">
            Submit Quiz
        </button>
    </div>
</div>

<script>
    // ---- Navigation helpers: they always submit the form so answer is saved ----
    function gotoQuestion(i) {
        document.getElementById('actionField').value = 'goto';
        document.getElementById('gotoField').value = i;
        document.getElementById('quizForm').submit();
    }
    function finishQuiz() {
        if (!confirm('Are you sure you want to submit the quiz?')) return;
        document.getElementById('actionField').value = 'finish';
        document.getElementById('quizForm').submit();
    }
    function confirmFinish() {
        if (!confirm('Are you sure you want to submit the quiz?')) return false;
        document.getElementById('actionField').value = 'finish';
        return true;
    }

    // ---- Server-authoritative timer ----
    let duration = <%= remaining %>;
    function tick() {
        if (duration < 0) {
            document.getElementById('actionField').value = 'finish';
            document.getElementById('quizForm').submit();
            return;
        }
        let m = Math.floor(duration / 60);
        let s = duration % 60;
        document.getElementById('timer').innerHTML =
            (m < 10 ? '0' : '') + m + ':' + (s < 10 ? '0' : '') + s;
        duration--;
    }
    tick();
    setInterval(tick, 1000);
</script>

</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3 style='color:red;text-align:center;margin-top:50px;'>Error: "
                    + e.getMessage() + "</h3>");
    } finally {
        try { if (rs2 != null) rs2.close(); } catch (Exception ex) {}
        try { if (ps2 != null) ps2.close(); } catch (Exception ex) {}
        try { if (con != null) con.close(); } catch (Exception ex) {}
    }
%>
