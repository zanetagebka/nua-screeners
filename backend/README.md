Thanks for applying to Webdoctor! Below you'll find our technical screener.

Please spend no more than half a day on this assignment. 

Send your answers (even if they're incomplete!) to gerard.kelly@webdoctor.ie

# About the screener

- When you're working on the coding questions, you should treat it like **real world production code**. We'll want to see a test suite, comments where required and things like that. It's important to **focus on the details**. It shouldn't feel like code you've hacked together in a rush, but something you'd be proud to have your name on.
- You can use whatever language you wish but since our devs are mostly experienced with Ruby, please ensure your code is well commented (or better yet, self-commenting!).
- We're pretty flexible on how you provide the answers. You can send over a link to a Github/Bitbucket repo, some folks send over a series of Github gists, others a zipped up copy of the code etc.

# Assignment

Given a CSV file with a list of doctors and the days and times they work over the next week, create a program that has a method which takes the input file, a day name and a time in 24 hour format and prints out the list of available doctors.

The initial method might look something like:

```
find_doctor('doctors.csv,' 'Tuesday',  '15:30')
```

The output maybe be something like:

```
Dr. O'Driscoll is available
Dr. O'Connell is available
```