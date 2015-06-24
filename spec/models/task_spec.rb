require 'rails_helper'

RSpec.describe Task, type: :model do

  describe '#toggle_complete!' do
    it 'should make an incomplete task complete' do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end

    it 'should make a complete task incomplete' do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
  end

  describe '#toggle_favorite!' do
    it 'should make a non favorite task a favorite' do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end

    it 'should make a favorite task a non favorite' do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
  end

  describe '#overdue?' do
    it 'should return true if deadline has already passed' do
      task = Task.create(deadline: 1.day.ago)
      expect(task.overdue?).to eq(true)
    end

    it 'should return false if deadline has not passed' do
      task = Task.create(deadline: 2.days.from_now)
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do
    it 'should increase the priority by 1' do
      task = Task.create(priority: 7)
      task.increment_priority!
      expect(task.priority).to eq(8)
    end

    it 'should keep the priority the same' do
      task = Task.create(priority: 12)
      task.increment_priority!
      expect(task.priority).to eq(12)
    end
  end

  describe '#decrement_priority!' do
    it 'should decrease the priority by 1' do
      task = Task.create(priority: 7)
      task.decrement_priority!
      expect(task.priority).to eq(6)
    end

    it 'should keep the priority the same' do
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do
    it 'should push the deadline off by one house' do
      task = Task.create(deadline: Time.new(2000, 1, 1))
      task.snooze_hour!
      expect(task.deadline).to eq(Time.new(2000, 1, 1) + 1.hour)
    end
  end
  

 
end
