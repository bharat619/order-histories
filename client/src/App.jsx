import { useContext, useEffect, useState } from "react";
import "./App.css";
import Users from "./components/Users";
import { CableContext } from "./context/cable";
import downloadCSV from "./utils/jsonToCSV";

function App() {
  const cableContext = useContext(CableContext);
  const [channel, setChannel] = useState(null);

  // Creating action cable channel at root level
  useEffect(() => {
    if (cableContext.cable.subscriptions.subscriptions.length === 1) return;

    const newChannel = cableContext.cable.subscriptions.create(
      {
        channel: "OrdersChannel",
      },
      {
        received: (data) => {
          downloadCSV(data);
        },
      }
    );
    setChannel(newChannel);

    return () => {
      if (!channel) return;

      channel.unsubscribe();
    };
  }, []);

  return (
    <>
      <div className="app">
        <h1>User Order Details</h1>
        <p>Click and download the order details</p>

        <Users />
      </div>
    </>
  );
}

export default App;
