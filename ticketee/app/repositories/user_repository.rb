class UserRepository < ROM::Repository::Root
  root :users

  commands :create, update: :by_pk, delete: :by_pk

  struct_namespace Users

  def by_id(id)
    root.by_pk(id).one
  end

  def all
    root.to_a
  end

  def contributors_for_project(project_id)
    users.contributors_for_project(project_id).to_a
  end

  def contributors_for_project_count(project_id)
    users.contributors_for_project(project_id).count
  end

  def top_contributors_for_project(project_id)
    users.top_contributors_for_project(project_id)
  end
end
