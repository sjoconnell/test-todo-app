require 'rails_helper'

RSpec.describe List, type: :model do

  describe '#complete_all_tasks!' do
    it 'should mark all tasks from the list as complete' do
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      expect(list.tasks.first.complete).to eq(true)
      expect(list.tasks.last.complete).to eq(true)
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should add 1 hour to the deadline of all the tasks from the list' do
      list = List.create(name: "Errands")
      Task.create(deadline: Time.new(2000, 1, 1), list_id: list.id)
      Task.create(deadline: Time.new(2000, 2, 1), list_id: list.id)
      list.snooze_all_tasks!
      expect(list.tasks.first.deadline).to eq(Time.new(2000, 1, 1) + 1.hour)
      expect(list.tasks.last.deadline).to eq(Time.new(2000, 2, 1) + 1.hour)
    end
  end

  describe '#total_duration' do
    it 'should return total as sum of all the tasks durations' do
      list = List.create(name: "Cars")
      Task.create(duration: 4, list_id: list.id)
      Task.create(duration: 7, list_id: list.id)
      expect(list.total_duration).to eq(11)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return all the incomplete tasks' do
      list = List.create(name: "Chores")
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: true, list_id: list.id)
      expect(list.incomplete_tasks.count).to eq(2)
    end
  end


end
