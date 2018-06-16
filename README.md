# GCPChallenges #2

Week 2:

This week's project will make use of the Flask python microframework for web applications. It has a fairly easy learning curve, and is a decent choice for small web applications, and for learning more about python in general. Flask has the concept of routes, which are simply urls that are tied to functions. For this week, we're going to focus on writing a _very_ basic app, configuring a managed instance group, and deploying an http(s) loadbalancer in front of the instance group. Additionally, if you haven't already, you should get into the habit of putting all of your code and tools into some form of source control. Using source control (and making regular commits), even on a single person project, can help provide a safety net should you make a disastrous change to some code and need to revert it. Additionally, most CI/CD pipelines begin with a code repository, so using source control will be helpful there as well.

## API Spec

GET /v1/api/hello_world

* Returns Plain Text 'Hello World'

GET /vi/api/hello_world/json

* Returns JSON object 

* { 'message' : 'hello world' }

POST /vi/api/math/square/$NUM1

* Returns JSON Object

* { 
  'expression' : '$NUM1 * $NUM1',
  'product' : '$ANS'
}

[Note: If input is not number return the appropriate HTTP error response]

POST /vi/api/math/sqrt/$NUM1

* Returns JSON Object

* { 
  'expression' : 'sqrt($NUM1)',
  'product' : '$ANS'
}



## This week's project:

* In this repository, create a python app using Flask and the provided spec.

* Create a bash script or CM management tool (your choice) config to build a Managed Instance group and HTTP(S) Loadbalancer

** The route will be for root (/), and should be something other than the Hello World example on the Flask website. Content is your choice.

** Commit your code to the repo frequently. Once you are satisfied with your work, create a Pull Request to merge the changes into the original bootcamp repository that you forked from me. I will review your code and provide feedback on what can be improved upon.

* Show how you would TLS terminate in two configurations: 
1) HTTP(S) TLS Termination 
2) TLS Termination in the instances in the Managed instance group

* Test that you can access the app from the ip.

* Create an instance template that uses the instance your application is running on as its reference.

* Create a zonal managed instance group that uses your template. Enable autoscaling.

* Create an https load balancer

* Ensure that you can reach the app using either http or https. Flask Documentation: http://flask.pocoo.org/ Creating Pull Requests: https://help.github.com/articles/creating-a-pull-request/

Bonus points:

* Use Deployment Manager to configure and deploy the load balancer
