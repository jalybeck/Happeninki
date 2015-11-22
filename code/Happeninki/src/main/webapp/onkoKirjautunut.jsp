<%
        if(session == null || session.getAttribute("kayttaja") == null) {
            request.getRequestDispatcher("kirjautuminen.jsp").forward(request, response);
            return;
        }
%>