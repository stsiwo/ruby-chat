import { createStyles, makeStyles, Theme } from "@material-ui/core/styles";
import { Channel } from "actioncable";
import { wsConsumer } from "configs/wsConfig";
import * as React from "react";

const useStyles = makeStyles((theme: Theme) =>
  createStyles({
    title: {
      textTransform: "uppercase",
      margin: theme.spacing(6),
    },
    subtotalBox: {
      padding: theme.spacing(1),
    },
    controllerBox: {
      textAlign: "center",
      margin: `${theme.spacing(3)}px 0`,
    },
    emptyBox: {
      minHeight: 300,
      padding: theme.spacing(1),
    },
    loadingBox: {
      height: "80vh",
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      flexDirection: "column",
    },
  })
);

const Appearance: React.FunctionComponent<{}> = (props) => {
  const classes = useStyles();

  const [curMessage, setMessage] = React.useState<string>();
  const [curAppearance, setAppearance] = React.useState<boolean>(false);

  React.useEffect(() => {
    console.log("start effect");
    const appearanceChannel: Channel = wsConsumer.subscriptions.create(
      {
        channel: "AppearanceChannel",
      },
      {
        // why this is not called??
        connected() {
          console.log("connected");
          setAppearance(true);
        },
        disconnected() {
          console.log("disconnected");
          setAppearance(false);
        },
        received(obj: any) {
          console.log("received");
        },
      }
    );
    console.log("channel object: ");
    console.log(appearanceChannel);
    wsConsumer.connect();
  });

  return <div>{curAppearance ? <div>online</div> : <div>offline</div>}</div>;
};

export default Appearance;
