import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import App from "./App.jsx";
import "./index.css";
import { CableProvider } from "./context/cable.jsx";

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <CableProvider>
      <App />
    </CableProvider>
  </StrictMode>
);
