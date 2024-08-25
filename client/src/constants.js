export const API_URL =
  process.env.NODE_ENV === "test"
    ? "http://mocked.api.com"
    : import.meta.env.VITE_API_URL;

export const CABLE_URL =
  process.env.NODE_ENV === "test"
    ? "wss://mocked.cable.com"
    : import.meta.env.VITE_CABLE_URL;
