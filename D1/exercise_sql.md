
# SQL Business Challenge: Data Analysis Exercise

## Objective

This business challenge is designed to apply the concepts of the `GROUP BY` and `HAVING` clauses in SQL. You will be working with a real-world dataset to perform data analysis and extract meaningful insights.

## Dataset

For this challenge, you will use the **"NYC 311 Service Requests"** dataset. This dataset is a rich repository of service requests logged by New York City's 311 service from 2010 to the present.

Dataset Link: [NYC 311 Service Requests Dataset](https://nycopendata.socrata.com/Social-Services/311-Service-Requests-from-2010-to-Present/erm2-nwe9)

## Challenge Tasks

1. **Identify the Top Complaint Types**
   - Query the dataset to find the top 5 complaint types based on the number of complaints logged.
   - Use `GROUP BY` to group the data by complaint type and `ORDER BY` to sort the results.

2. **Analyze Complaints by Borough**
   - Calculate the total number of complaints for each borough.
   - Use the `GROUP BY` clause to group data by borough.

3. **Filtering High-Volume Complaint Types**
   - Use the `HAVING` clause to filter out complaint types that have more than 1000 complaints logged.
   - Display the complaint type and the count of complaints.

4. **Comparison of Boroughs for a Specific Complaint Type**
   - Choose a particular type of complaint.
   - Compare the number of such complaints in each borough.

## Deliverables

- SQL queries for each task.
- Brief analysis of the results obtained from each query.

## Tips

- Pay attention to the data types and structure of the dataset.
- Use aggregate functions like `COUNT()` effectively with `GROUP BY` and `HAVING`.
- Ensure your queries are efficient and well-structured.

Good luck, and have fun with the challenge!
