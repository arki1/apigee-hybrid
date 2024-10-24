# Apigee Hybrid Setup

This is a collection of small scripts to help install and manage Apigee Hybrid.
This project provides a "shell script approach" for the same steps available in
[the Apigee Hybrid documentation](https://cloud.google.com/apigee/docs/hybrid/v1.13/precog-overview).

**Notice: These scripts are intended for study pourposes only.**
A better aproach for automation would be using Terraform for a production setting.

This is an oppinionated setup designed to showcase Hybrid on GKE. All sizing and
scaling considerations were made to simplify this process and for a demo showcase,
not for production scaling needs.

**Prerequisites:**

* Make the apropriate changes to the `configure.sh` script.
* Before you begin, ensure you have sourced the `configure.sh` file.
  Start with `installation/part1/step1.sh`.
* If your Cloud Shell disconnects, ensure you have sourced `configure.sh` again.

**Steps:**

For each part (part1, part2, part3), execute each step in order.
It is advised to read the contents of the scripts to familiarize yourself with
what will be executed. Some parts may be skipped, for instance, if the script
contents are already executed previously.

Make sure that the desired output was created by
browsing to the appropriate page in Cloud Console.
For instance, after Part 1 is completed, you should be able to go to the
Apigee page and see that the environments were created.