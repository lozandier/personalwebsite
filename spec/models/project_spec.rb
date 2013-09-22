require 'spec_helper'

describe Project do
  it { should have_many :technology_profiles }
  it { should have_many :photos }
  it { should have_many :technologies }
  context "new Project" do 
    subject { Project.new }
    it { should_not be_valid }
    #it { sh}
  end
end
