This script will ask you initially which folder you would like to store your project.

Once you have entered the folder name, type in the name you wish to give your project.

This will then create your solution item, all projects with relevant references, and a Health Check.

I have done this so I could start learning .Net 6 using VS Code.

Once your project has been created, open it in Visual Studio Code, open a terminal within and Navigate to the Lambda folder, then into the .Lambda project.  Type in "dotnet run".

This should run your project.  In the terminal, Ctrl and Click any of the two links.  This should open a new tab.  At the end of that URL, add the following "/api/healthcheck" and press enter.  You should get a system date time along with a simple can it reach the internet (a ping to google.com).