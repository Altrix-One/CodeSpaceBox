# FOSS UNITED

# CodeSpaceBox 🚀  
A collection of **predefined sandboxes** for developing and experimenting with **Frappe Modules**. Whether you're building apps, customizing ERP workflows, or exploring Frappe’s capabilities, CodeSpaceBox provides ready-to-use environments to supercharge your development experience.

---

## 🎯 Features

- **Preconfigured Sandboxes**: Jumpstart your Frappe projects with tailored environments for specific modules.  
- **Modular Design**: Easily switch between sandboxes for apps like Accounting, HR, CRM, and more. Choose the correct branch and start the codespace.
- **Simplified Setup**: Spend less time on configurations and more time building.

## Installation

- This project works the best on the latest Frappe Version v15. And is suggested to be installed on the same.
- Checkout Frappe Framework [Installation Docs](https://frappeframework.com/docs/) for setting up frappe on your [bench](https://frappeframework.com/docs/user/en/tutorial/install-and-setup-bench).

- Create a new bench with
  `bench init fossu-bench`
- Clone the FOSS United Platform App.
  `bench get-app https://github.com/fossunited/fossunited`
- Create a [new site](https://frappeframework.com/docs/user/en/tutorial/create-a-site)
  `bench new-site test.localhost`
- Install the App on the created site
  `bench --site test.localhost install-app fossunited`
- Finally,
  `bench start`

Checkout [Access site in your browser](https://frappeframework.com/docs/user/en/tutorial/create-a-site#access-site-in-your-browser) for adding hosts.

### Steps to install and run the [FOSS United Dashboard](https://fossunited.org/dashboard)

The FOSS United Dashboard is a centralised admin UI for all the users signed up on fossunited.org. The Dashboard provides volunteers with the feature to manage all of the activities happening in their FOSS Club or City Chapter. Here are the steps to install and get the dashboard going:

- The code for dashboard is located under `fossunited/dashboard`.
- Install and Build the dashboard with `yarn install`.
- Run the dashboard in the root directory of the project with `yarn dev`.
- Dashboard will now be accessible on `<sitename>:8080`.

## Pre-commit

For automatic running of linters before you commit:

```
$ pip install pre-commit
$ pre-commit install
```
