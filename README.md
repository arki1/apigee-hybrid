## Apigee Hybrid Setup

This is a collection of small scripts to help set up Apigee Hybrid.
This project provides a "script approach" for the steps available in
[the Apigee Hybrid documentation](https://cloud.google.com/apigee/docs/hybrid/v1.13/precog-overview).

These scripts may be better automated using Terraform in the future.

**Prerequisites:**

* Before you begin, ensure you have sourced the `environment.sh` file. Start with `part1/step1.sh`.
* If your Cloud Shell disconnects, ensure you have sourced `environment.sh` again.

**Steps:**

For each part (part1, part2, part3), execute each step in order.
It is advised to read the contents of the scripts to familiarize yourself with
what will be executed.

Make sure that the desired output was created by
browsing to the appropriate page in Cloud Console.
For instance, after Part 1 is completed, you should be able to go to the
Apigee page and see that the environments were created.