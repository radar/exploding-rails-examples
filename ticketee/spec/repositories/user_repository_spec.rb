require 'rails_helper'

describe UserRepository do
  let(:project_repo) { ProjectRepository.new(ROM.env) }
  let(:ticket_repo) { TicketRepository.new(ROM.env) }
  let(:user_repo) { described_class.new(ROM.env) }

  context "contributors_for_project" do
    let!(:project_1) { project_repo.create(name: "Ticketee") }
    let!(:project_2) { project_repo.create(name: "Ticketee v2") }

    let!(:user_1) { user_repo.create(username: "annie") }
    let!(:user_2) { user_repo.create(username: "bob") }
    let!(:user_3) { user_repo.create(username: "charlie") }

    let!(:ticket_1) do
      ticket_repo.create(
        title: "First bug",
        comment: "This is the first bug",
        user_id: user_1.id,
        project_id: project_1.id,
      )
    end

    let!(:ticket_2) do
      ticket_repo.create(
        title: "Second bug",
        comment: "This is the second bug",
        user_id: user_1.id,
        project_id: project_1.id,
      )
    end

    let!(:ticket_3) do
      ticket_repo.create(
        title: "Third bug",
        comment: "This is the third bug",
        user_id: user_2.id,
        project_id: project_1.id,
      )
    end

    let!(:ticket_4) do
      ticket_repo.create(
        title: "First bug, 2nd project",
        comment: "This is the first bug in the 2nd project",
        user_id: user_3.id,
        project_id: project_2.id,
      )
    end

    it "finds contributors for the project" do
      contributors = user_repo.contributors_for_project(project_1.id)
      expect(contributors.count).to eq(2)
      expect(contributors).to include(user_1)
      expect(contributors).to include(user_2)
      expect(contributors).not_to include(user_3)
    end
  end

  context "top_contributors_for_project" do
    let!(:project_1) { project_repo.create(name: "Ticketee") }

    let!(:user_1) { user_repo.create(username: "annie") }
    let!(:user_2) { user_repo.create(username: "bob") }
    let!(:user_3) { user_repo.create(username: "charlie") }

    let!(:ticket_1) do
      ticket_repo.create(
        title: "First bug",
        comment: "This is the first bug",
        user_id: user_1.id,
        project_id: project_1.id,
      )
    end

    let!(:ticket_2) do
      ticket_repo.create(
        title: "Second bug",
        comment: "This is the second bug",
        user_id: user_1.id,
        project_id: project_1.id,
      )
    end

    let!(:ticket_3) do
      ticket_repo.create(
        title: "Third bug",
        comment: "This is the third bug",
        user_id: user_2.id,
        project_id: project_1.id,
      )
    end

    it "finds top contributors for the project" do
      top_contributors = user_repo.top_contributors_for_project(project_1.id)
      expect(top_contributors.count).to eq(2)
      expect(top_contributors.first.username).to eq(user_1.username)
      expect(top_contributors.second.username).to eq(user_2.username)
    end
  end
end
