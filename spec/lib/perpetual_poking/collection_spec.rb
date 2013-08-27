require 'spec_helper'
describe PerpetualPoking::Collection do
  subject { PerpetualPoking::Collection.new(Object) }
  it { should respond_to(:params) }
  it { should respond_to(:limit) }
  it { should respond_to(:where) }
  context 'params' do
    it 'should create a hash if there are no params' do
      subject.params.should be_kind_of Hash
      subject.params.should be_empty
    end
  end
  context 'limit' do
    it 'should set a limit in the params' do
      subject.limit(10)
      puts subject.inspect
      subject.params.should have_key(:limit)
      subject.params[:limit].should eq 10
    end
    it 'should overwrite limits if called more than once' do
      subject.limit(20)
      subject.limit(10)
      subject.params.should have_key(:limit)
      subject.params[:limit].should eq 10
    end
    it 'should return self' do
      subject.limit(10).should be_kind_of PerpetualPoking::Collection
    end
    it 'should be chainable' do
      foo = subject.limit(10).limit(5)
      foo.should be_kind_of PerpetualPoking::Collection
      foo.params.should have_key(:limit)
      foo.params[:limit].should eq 5
    end
  end
  context 'where' do
    it 'should add to the params' do
      subject.where(foo: :bar)
      subject.params.should have_key(:foo)
      subject.params[:foo].should eq :bar
    end

    it 'should overwrite keys with the same name' do
      subject.where(foo: :bar)
      subject.where(foo: :baz)
      subject.params.should have_key(:foo)
      subject.params[:foo].should eq :baz
    end
    it 'should be chainable' do
      subject.where(foo: :bar).where(foo: :baz)
      subject.params.should have_key(:foo)
      subject.params[:foo].should eq :baz
    end
    it 'should return self' do
      subject.where(foo: :bar).should be_kind_of PerpetualPoking::Collection
    end
  end
  context 'each' do
    it 'should execute the given block on each member'
  end
  context 'run' do
    it 'should call search on the klass with the params'
    it 'should create a new instance of klass for each result'
    it 'should set metadata'
  end
end
