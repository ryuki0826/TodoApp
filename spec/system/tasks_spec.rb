require 'rails_helper'

describe 'タスク管理画面一覧', type: :system do
  let(:user_a){FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
  let(:user_b){FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
  let!(:task_a){FactoryBot.create(:task, name: '最初のタスク', user: user_a)}
  
  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end
  
  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it {expect(page).to have_content '最初のタスク'}
  end
  
  describe '#index' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) {user_a}
      
      it_behaves_like 'ユーザーAが作成したタスクが表示される' 
    end
    
    context 'ユーザーBがログインしているとき' do
      let(:login_user) {user_b}
      
      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end
  
  describe '#show' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) {user_a}
      
      before do
        visit task_path(task_a)
      end
      
      it_behaves_like 'ユーザーAが作成したタスクが表示される' 
    end
  end
  
  describe '#new' do
    let(:login_user) {user_a}
    let(:task_name) {'新規作成のテストを書く'}
     
    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録する'
    end
    
    context '新規作成画面で名称を入力したとき' do
     
      
      it '正常に登録される' do
        expect(page).to have_selector '.alert-success',text: '新規作成のテストを書く'
      end
    end
    
    context '新規作成画面で名称を入力しなかったとき' do
      let(:task_name) {''}
      
      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end
  
  describe '#edit' do
    let(:login_user) {user_a}
    let(:task_name) {'編集したタスク'}
    before do
      visit edit_task_path(task_a)
      fill_in '名称', with: task_name
      click_button '更新する'
    end
     
      
    context '更新画面で名称を入力したとき' do
      it '正常に登録される' do
        expect(page).to have_selector '.alert-success',text: '編集したタスク'
      end
    end
    
    context '編集画面で名称を入力しなかったとき' do
      let(:task_name) {''}
      
      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
    
  end
  
end