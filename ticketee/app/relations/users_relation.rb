class UsersRelation < ROM::Relation[:sql]
  gateway :default

  schema(:users, infer: true)

  # define your methods here ie:
  #
  # def all
  #   select(:id, :name).order(:id)
  # end

  def contributors_for_project(project_id)
    distinct(:id)
      .inner_join(:tickets, user_id: :id)
      .where(project_id: project_id)
  end

  def top_contributors_for_project(project_id)
    top_contributors.for_project(project_id, 11).to_a
  end
end
