import { PayloadAction } from "@reduxjs/toolkit";
import { api, WorkerResponse } from "configs/axiosConfig";
import { logger } from "configs/logger";
import { messageActions } from "reducers/slices/app";
import { postUserAvatarImageFetchStatusActions } from "reducers/slices/app/fetchStatus/user";
import {
  PostUserAvatarImageActionType,
  userActions,
} from "reducers/slices/domain/user";
import { call, put, select } from "redux-saga/effects";
import {
  AuthType,
  FetchStatusEnum,
  MessageTypeEnum,
  UserTypeEnum,
} from "src/app";
import { rsSelector } from "src/selectors/selector";
import { getNanoId } from "src/utils";

const log = logger(__filename);

/**
 * a worker (generator)
 *
 *  - post user avatar image
 *
 *  - NOT gonna use caching since it might be stale soon and the user can update any time.
 *
 *  - (UserType)
 *
 *      - (Guest): N/A (permission denied)
 *      - (Member): OK
 *      - (Admin): OK
 *
 *  - steps:
 *
 *
 *  - note:
 *
 *    - this is to update other's avatar image (not for your own like auth)
 *
 **/
export function* postUserAvatarImageWorker(
  action: PayloadAction<PostUserAvatarImageActionType>
) {
  /**
   * get cur user type
   **/
  const curAuth: AuthType = yield select(rsSelector.app.getAuth);

  /**
   *
   * Admin User Type
   *
   **/
  if (curAuth.userType === UserTypeEnum.ADMIN) {
    /**
     * update status for put user data
     **/
    yield put(
      postUserAvatarImageFetchStatusActions.update(FetchStatusEnum.FETCHING)
    );

    /**
     * grab this  domain
     **/
    const apiUrl = `${API1_URL}/users/${action.payload.userId}/avatar-image`;

    /**
     * fetch data
     **/

    // prep form data
    const formData = new FormData();
    formData.append("avatarImage", action.payload.avatarImage);

    // start fetching
    const response: WorkerResponse = yield call(() =>
      api({
        method: "POST",
        headers: {
          "If-Match": `"${action.payload.version}"`,
          "Content-Type": "multipart/form-data",
        },
        url: apiUrl,
        data: formData,
      })
        .then((response) => ({
          fetchStatus: FetchStatusEnum.SUCCESS,
          data: response.data,
        }))
        .catch((e) => ({
          fetchStatus: FetchStatusEnum.FAILED,
          message: e.response.data.message,
        }))
    );
    /**
     * update fetch status sucess
     **/
    yield put(
      postUserAvatarImageFetchStatusActions.update(response.fetchStatus)
    );

    if (response.fetchStatus === FetchStatusEnum.SUCCESS) {
      /**
       * update this domain in state
       *
       **/

      yield put(
        userActions.updateUser({
          userId: response.data.userId,
          user: response.data,
        })
      );

      /**
       * update message
       **/
      yield put(
        messageActions.update({
          id: getNanoId(),
          type: MessageTypeEnum.SUCCESS,
          message: "added successfully.",
        })
      );
    } else if (response.fetchStatus === FetchStatusEnum.FAILED) {
      log(response.message);

      /**
       * update fetch status failed
       **/
      yield put(
        postUserAvatarImageFetchStatusActions.update(FetchStatusEnum.FAILED)
      );
    }
  } else {
    log("permission defined: you are " + curAuth.userType);
  }
}
