#splitting salary_range into minimum and maximum salary columns and dropping the salary_range column
def split_salary_range(df):
    df['minimum_salary'] = df['salary_range'].str.split('-', expand=True)[0]
    df['maximum_salary'] = df['salary_range'].str.split('-', expand=True)[1]
    df.drop('salary_range', axis=1, inplace=True)
    return df
#corolation matrix for the dataset ignoring nan values and categorical values
def correlation_heatmap(df):
    _ , ax = plt.subplots(figsize =(14, 12))
    colormap = sns.diverging_palette(220, 10, as_cmap = True)
    
    _ = sns.heatmap(
        df.corr(), 
        cmap = colormap,
        square=True, 
        cbar_kws={'shrink':.9 }, 
        ax=ax,
        annot=True, 
        linewidths=0.1,vmax=1.0, linecolor='white',
        annot_kws={'fontsize':12 }
    )
    
    plt.title('Pearson Correlation of Features', y=1.05, size=15)
#plotting the accuracy, precision, recall and f1 score of the three models
def plot_model_performance(model_performance):
    model_performance.plot(kind='bar', figsize=(10, 5))
    plt.title('Model Performance')
    plt.xlabel('Model')
    plt.ylabel('Score')
    plt.legend(loc='lower right')
    plt.xticks(rotation=0)
    plt.show()