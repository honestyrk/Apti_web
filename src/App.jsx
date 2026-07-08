import { useState } from 'react'
import viteLogo from './assets/vite.svg'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <main className="app-shell">
      <section className="hero">
        <img src={viteLogo} className="logo" alt="Vite logo" />
        <h1>Apti Web</h1>
        <p>Starter app is running successfully.</p>
        <button type="button" onClick={() => setCount((value) => value + 1)}>
          Count is {count}
        </button>
      </section>
    </main>
  )
}

export default App
