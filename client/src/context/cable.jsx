import { createContext } from "react";
import ActionCable from "actioncable";

import { CABLE_URL } from "../constants";

const CableContext = createContext();

const CableProvider = ({ children }) => {
  const CableApp = {};

  CableApp.cable = ActionCable.createConsumer(CABLE_URL);

  return (
    <CableContext.Provider value={CableApp}>{children}</CableContext.Provider>
  );
};

export { CableContext, CableProvider };
