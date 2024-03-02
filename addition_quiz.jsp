// Fady Zaki SDEV200 3/2/24
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Addition Quiz</title>
</head>
<body>
    <h2>Addition Quiz</h2>
    <form action="addition_quiz.jsp" method="post">
        <%@ page import="java.util.Random" %>
        <%@ page import="java.util.ArrayList" %>
        <%@ page import="java.util.List" %>
        <%@ page import="java.util.Collections" %>

        <%-- Number of questions in the quiz --%>
        <% int numQuestions = 5; %>
//Numbr of questions can be changed here
        <%-- Generate random addition questions --%>
        <%
            Random random = new Random();
            List<String> questions = new ArrayList<String>();
            List<Integer> answers = new ArrayList<Integer>();
            
            for (int i = 0; i < numQuestions; i++) {
                int num1 = random.nextInt(10); 
                int num2 = random.nextInt(10); 
                int sum = num1 + num2;
                questions.add(num1 + " + " + num2 + " = ");
                answers.add(sum);
            }
            
            Collections.shuffle(questions);
            Collections.shuffle(answers);

            session.setAttribute("answers", answers);
        %>

        <%-- Display questions --%>
        <%
            for (int i = 0; i < numQuestions; i++) {
        %>
                <%= questions.get(i) %> <input type="text" name="userAnswers"/><br>
        <%      
            }
        %>
        
        <input type="submit" value="Submit"/>
    </form>

    <%-- Process the form submission and display results --%>
    <% 
        String[] userAnswers = request.getParameterValues("userAnswers");
        int score = 0;
        if (userAnswers != null && userAnswers.length == numQuestions) {
            List<Integer> correctAnswers = (List<Integer>) session.getAttribute("answers");
            for (int i = 0; i < numQuestions; i++) {
                int userAnswer = Integer.parseInt(userAnswers[i]);
                if (userAnswer == correctAnswers.get(i)) {
                    score++;
                }
            }
            out.println("<h3>Result:</h3>");
            out.println("<p>You got " + score + " out of " + numQuestions + " questions correct.</p>");
        }
    %>

</body>
</html>
