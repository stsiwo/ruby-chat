import actioncable, { Cable } from "actioncable";

export const wsConsumer: Cable = actioncable.createConsumer(
  `ws:${API1_DOMAIN}/cable`
);
