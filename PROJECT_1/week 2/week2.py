import pandas as pd
import numpy as np

enroll_df = pd.read_csv('enrollment.csv')
prog_df = pd.read_csv('progress.csv')

all_poss_id = set(range(1,len(enroll_df)+1))
exist_id = set(enroll_df['student_id'].dropna().astype(int))
missing_id = sorted(list(all_poss_id - exist_id))

miss_index = enroll_df['student_id'].isna()
for i,idx in enumerate(enroll_df[miss_index].index):
    if i < len(missing_id):
        enroll_df.at[idx,'student_id']=missing_id[i]
    else:
        enroll_df.at[idx,'student_id']= -1

enroll_df['student_id'] = enroll_df['student_id'].astype(int)

enroll_df['enrollment_date'] = enroll_df['enrollment_date'].fillna('2024-01-30')

prog_df['completion_percentage'] = pd.to_numeric(prog_df['completion_percentage'],errors = "coerce" ).fillna(50)

prog_df['completion_percentage'] = np.clip(prog_df['completion_percentage'],0,100)

prog_df['last_updated'] = prog_df['last_updated'].fillna('2024-02-15')

merged_df = pd.merge(prog_df,enroll_df,on='enrollment_id',how='left')

overall_avg = np.mean(merged_df['completion_percentage'])
#print(overall_avg)

course_avg = merged_df.groupby('course_id')['completion_percentage'].mean()
#print(course_avg)

merged_df.to_csv('cleaned_students_progress.csv',index=False)

course_avg.reset_index().to_csv('course_report.csv',index = False)