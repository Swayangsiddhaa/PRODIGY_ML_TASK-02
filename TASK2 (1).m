%Clear all workspace and close all figures.
clear all;
close all;
format longG;

%Download the dataset from a URL.
dataset_url = "https://github.com/Swayangsiddhaa/PRODIGY_ML_TASK-02/raw/main/Mal_Customers.xlsx"; % Raw link to your file
output_file = "Mal_Customers.xlsx";
websave(output_file, dataset_url);

%Read the dataset into a table with 'preserve' option for
%VariableNamingRule.
opts = detectImportOptions(output_file);
opts.VariableNamingRule = 'preserve';
DATA_SET = readtable(output_file);

%Displaying data sheet after importing to matlab.
disp("Data sheet for Mall Customers:-")
disp(DATA_SET)

%Checking for missing values in the data sheet.
Check_missing_Values = sum(ismissing(DATA_SET));
disp("Missing values are:-")
disp(Check_missing_Values)

% Extraction of columns 4 and 5 from Mal_Customers.
Data = DATA_SET(:, 4:5);
disp("Data sheet of Mall Customers including only AnnualIncome & SpendingScore")
disp(Data)

%Standarisation of the required columns.
Data.AnnualIncome_k__ = (Data.AnnualIncome_k__ - mean(Data.AnnualIncome_k__)) / std(Data.AnnualIncome_k__);
Data.SpendingScore_1_100_ = (Data.SpendingScore_1_100_ - mean(Data.SpendingScore_1_100_)) / std(Data.SpendingScore_1_100_);
disp("Data sheet of Mall Customers including only Standardized AnnualIncome & SpendingScore")
disp(Data)

%Convertion of table to array.
Data = table2array(Data);

%Initialisation of total sumd. and clustervalues.
sumdtotal=[];
K=[];

% Performing k-means clustering for k = 1 to 20 and storing the total sum
% of distances.
for k = 1:20
    [idx, c, sumd] = kmeans(Data, k);
    sumdtotal = [sumdtotal sum(sumd)];
    K = [K k];
end 

%Graph plotting for elbow method,to find best value for k.
figure;
plot(K, sumdtotal);
xlabel('Number of Clusters (k)');
ylabel('Total Within-Cluster Sum of Squares');
title('Elbow Method for Optimal k');

% Performing k-means clustering with k = 6.
[idx, c] = kmeans(Data, 6);

% Graph Plot for the clusters.
figure;
gscatter(Data(:, 1), Data(:, 2), idx);
xlabel('Standardized Annual Income');
ylabel('Standardized Spending Score');
title('K-means Clustering');
