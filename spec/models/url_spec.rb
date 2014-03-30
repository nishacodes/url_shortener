require 'spec_helper'

describe Url do
  it 'is invalid without a url' do
    expect(Url.new(original: nil)).to have(2).errors_on(:original)
  end

  it 'is invalid with a duplicate shortened url' do
    url = Url.create(original: "http://www.testing.com/abcdefg")
    url.shortened = "http://nis.ha/#{url.encode}"
    url.save
    expect(Url.create(original: "http://www.testing.com/abc", shortened: url.shortened)).to have(1).errors_on(:shortened)
  end

  it 'is invalid with an incorrect url format' do
    expect(Url.new(original: "abcdefg")).to have(1).errors_on(:original)
    expect(Url.new(original: "http:/www.nisha.com")).to have(1).errors_on(:original)
    expect(Url.new(original: "http//www.nisha.com")).to have(1).errors_on(:original)
    expect(Url.new(original: "htp://www.nisha.com")).to have(1).errors_on(:original)
    expect(Url.new(original: "http://nisha")).to have(1).errors_on(:original)
  end

  describe '#encode' do
    it 'returns a unique string of letters and numbers 5 chars or less' do
      url = Url.create(original: "http://www.testing.com/abcdefg")
      expect(url.encode.length).to be <=(5)
    end
  end

  describe '#decode' do
    it 'returns the URL id' do
      url = Url.create(original: "http://www.testing.com/abcdefg")
      url.shortened = "http://nis.ha/#{url.encode}"
      url.save
      expect(url.decode).to eq(url.id)
    end
  end

end