require 'rails_helper'

RSpec.describe Donvert, type: :model do
  subject { Donvert.new(title: 'compost', description: "c'est du compost c'est le mien 123456",
                        donateur_type: "particulier", type_matiere_orga: 'compost',
                        donneur_name: 'jp', donneur_address: "4 rue du hédas, Pau",
                        donneur_email: 'okok@email.com', donneur_tel: '0123456789',
                        date_fin_dispo: Date.today + 3.weeks) }
  before { subject.save }

  it 'should be a valid subject' do
    is_expected.to be_valid
  end

  it 'should have a title' do
    subject.title = nil
    is_expected.to_not be_valid
  end

  it 'should have a long enough title' do
    subject.title = 'nope'
    is_expected.to_not be_valid
  end

  it 'should have a description' do
    subject.description = nil
    is_expected.to_not be_valid
  end

  it 'should have a long enough description' do
    subject.description = 'too short'
    is_expected.to_not be_valid
  end

  it 'should have a donateur_type' do
    subject.donateur_type = nil
    is_expected.to_not be_valid
  end

  it 'should have a donateur_type from the list' do
    subject.donateur_type = 'very special'
    is_expected.to_not be_valid
  end

  it 'should have a type_matiere_orga' do
    subject.type_matiere_orga = nil
    is_expected.to_not be_valid
  end

  it 'should have a type_matiere_orga from the list' do
    subject.type_matiere_orga = 'my new car'
    is_expected.to_not be_valid
  end

  it 'should have a donneur_name' do
    subject.donneur_name = nil
    is_expected.to_not be_valid
  end

  it 'should have a donneur_address' do
    subject.donneur_address = nil
    is_expected.to_not be_valid
  end

  it 'should have a donneur_email' do
    subject.donneur_email = nil
    is_expected.to_not be_valid
  end

  it 'should have a donneur_tel' do
    subject.donneur_tel = nil
    is_expected.to_not be_valid
  end

  it 'should have a date_fin_dispo in the future' do
    subject.date_fin_dispo = Date.today - 2.weeks
    is_expected.to_not be_valid
  end

  it 'should have a slug' do
    expect(subject.slug).to_not be_nil
  end

  it 'should have a codeword' do
    expect(subject.codeword).to_not be_nil
  end

  it 'should send confirmation don email' do
    expect { subject.instance_eval { send_confirmation_don_email } }.to change { ActionMailer::Base.deliveries.count }.by(1)
    expect(ActionMailer::Base.deliveries.last.subject).to eq("Votre don est en ligne !")
    expect(ActionMailer::Base.deliveries.last.to.first).to eq(subject.donneur_email)

  end
end