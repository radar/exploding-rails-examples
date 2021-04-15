# frozen_string_literal: true

ROM::SQL.migration do
  change do
    contribution_groups = self[:tickets].select { [count(id).as(:count), user_id, project_id] }
      .order(nil)
      .group_and_count(:project_id, :user_id)

    rankings = self[:contribution_groups].select do |cg|
      [
        cg.project_id,
        cg.user_id,
        cg.count,
        cg.rank.function.over(partition: cg.project_id, order: Sequel.desc(cg.count))
      ]
    end

    top_contributors = self[:rankings]
      .with(:contribution_groups, contribution_groups)
      .with(:rankings, rankings)
      .select(:username, :rank, :project_id)
      .join(:users, id: :user_id)
      .order(:rank)

    create_view :top_contributors, top_contributors
  end
end
