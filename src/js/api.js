import _ from 'lodash';

class UrbitApi {
  setAuthTokens(authTokens) {
    this.authTokens = authTokens;
    this.bindPaths = [];
  }

  bind(path, method, ship = this.authTokens.ship, appl = "landscapetest", success, fail) {
    this.bindPaths = _.uniq([...this.bindPaths, path]);

    window.subscriptionId = window.urb.subscribe(ship, appl, path,
      (err) => {
        fail(err);
      },
      (event) => {
        success({
          data: event,
          from: {
            ship,
            path
          }
        });
      },
      (err) => {
        fail(err);
      });
  }

  landscapetest(data) {
    this.action("landscapetest", "json", data);
  }

  action(appl, mark, data) {
    return new Promise((resolve, reject) => {
      window.urb.poke(ship, appl, mark, data,
        (json) => {
          resolve(json);
        },
        (err) => {
          reject(err);
        });
    });
  }
}
export let api = new UrbitApi();
window.api = api;
