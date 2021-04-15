Dry::Rails.container do
  config.features = %i[application_contract]
  auto_register!('lib', 'app/operations')

  register(:project_repo, -> { ProjectRepository.new(ROM.env) })
  register(:user_repo, -> { UserRepository.new(ROM.env) })
end
