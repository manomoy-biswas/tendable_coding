# Tendable Coding Assessment

## Usage

```sh
bundle
ruby questionnaire.rb
```

## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Approach
1. Modifying the existing code and introduce class for writing rspec properly.
2. moving the existing code file  in the lib folder
3. in the `do_promt` method, I updated the loop and added a validation on each input.
4. I'm downcasing the input received from user to support case insensitivity
5. If input not an expected input (i.e. yes / y / no / n) it will promt a Invalid response and ask for the input again.
6. Once it collects all input it will store the response in a json structure using pstore.
7. Once stored, when we trigger `do_report` it will calculate the agerage everytime for all its execution and print thr report.


## Bash Script to Execure The file
* Make sure Ruby installed in your local machine
```sh
  sh run.sh
```

## Unit Testcases added

# code Comment added

## Docker Command
```sh
  docker build -t tendable /path/to/the/directory
```
```sh
  docker run -it tendable
```

## Bonus Points

Updated readme with an explanation of your approach

Unit Tests

Code Comments

Dockerfile / Bash script if needed for us to run the exercise

