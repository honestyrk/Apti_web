import { Routes, Route } from 'react-router-dom'
import Layout from './components/layout/Layout'
import ProtectedRoute from './components/layout/ProtectedRoute'
import AdminRoute from './components/layout/AdminRoute'

import HomePage from './pages/HomePage'
import LoginPage from './pages/LoginPage'
import SignupPage from './pages/SignupPage'
import DashboardPage from './pages/DashboardPage'
import CategoriesPage from './pages/CategoriesPage'
import CategoryDetailPage from './pages/CategoryDetailPage'
import BranchTopicsPage from './pages/BranchTopicsPage'
import PracticePage from './pages/PracticePage'
import TestSetupPage from './pages/TestSetupPage'
import TestPage from './pages/TestPage'
import ResultsPage from './pages/ResultsPage'
import HistoryPage from './pages/HistoryPage'
import ProfilePage from './pages/ProfilePage'
import NotFoundPage from './pages/NotFoundPage'

import AdminDashboardPage from './pages/admin/AdminDashboardPage'
import AdminQuestionsPage from './pages/admin/AdminQuestionsPage'
import AdminQuestionFormPage from './pages/admin/AdminQuestionFormPage'
import AdminTopicsPage from './pages/admin/AdminTopicsPage'

function App() {
  return (
    <Routes>
      <Route element={<Layout />}>
        <Route path="/" element={<HomePage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/signup" element={<SignupPage />} />

        <Route element={<ProtectedRoute />}>
          <Route path="/dashboard" element={<DashboardPage />} />
          <Route path="/categories" element={<CategoriesPage />} />
          <Route path="/categories/:categorySlug" element={<CategoryDetailPage />} />
          <Route path="/categories/:categorySlug/branches/:branchSlug" element={<BranchTopicsPage />} />
          <Route path="/practice/:topicId" element={<PracticePage />} />
          <Route path="/test/setup" element={<TestSetupPage />} />
          <Route path="/test/setup/:topicId" element={<TestSetupPage />} />
          <Route path="/test/:attemptId" element={<TestPage />} />
          <Route path="/test/:attemptId/results" element={<ResultsPage />} />
          <Route path="/history" element={<HistoryPage />} />
          <Route path="/profile" element={<ProfilePage />} />
        </Route>

        <Route element={<AdminRoute />}>
          <Route path="/admin" element={<AdminDashboardPage />} />
          <Route path="/admin/questions" element={<AdminQuestionsPage />} />
          <Route path="/admin/questions/new" element={<AdminQuestionFormPage />} />
          <Route path="/admin/questions/:id/edit" element={<AdminQuestionFormPage />} />
          <Route path="/admin/topics" element={<AdminTopicsPage />} />
        </Route>

        <Route path="*" element={<NotFoundPage />} />
      </Route>
    </Routes>
  )
}

export default App
