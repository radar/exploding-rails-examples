Rails.application.routes.draw do
  root to: "projects/projects#index"

  scope module: :projects, as: :projects do
    resources :projects
  end
end
