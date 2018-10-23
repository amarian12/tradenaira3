json.extract! project, :title,
                       :blurb,
                       :description,
                       :end_date,
                       :total_amount,
                       :funding_goal,
                       :image_url,
                       :id,
                       :user_id,
                       :category_id,
                       :author


json.id project.id
# json.author project.author
# json.amount_pledged project.amount_pledged
