<a name="readme-top"></a>

<div align="center">
  <h3><b>RELEVECA Back end</b></h3>

</div>

<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [📖 Kanban Boards](#Kanban-boards)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
  - [🚀 Live Demo](#live-demo)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
  - [Usage](#usage)
  - [Run tests](#run-tests)
  - [Deployment](#triangular_flag_on_post-deployment)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 📖 RELEVECA BE <a name="about-project"></a>

**RELEVECA End** is the Back End project for the RELEVECA multi-corporation Project. The back end is developed using Rails and PostgreSQL. We used JWT tokens for authentication between front and back ends. A JWT token will be generated every time a user logs in.

### Front end
The front end part of the project is under construction and can be found in this repo: [Frontend repository](https://github.com/anthonymr/releveca-frontend)

### API Design
Here you can find the API design (which is constantly updated): [API design](https://languid-ambulance-bb3.notion.site/API-Design-3d39bb83b11e4a5b8b228a90b2527924?pvs=4)

<p align="right">(<a href="#readme-top">back to top</a>)</p>
## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

  <ul>
    <li><a href="https://rubyonrails.org/">Ruby</a></li>
    <li><a href="https://www.ruby-lang.org/">Rails</li>
    <li><a href="https://www.postgresql.org/">PotsgreSQL</li>
    <li><a href="https://vuejs.org/">Vue 3</li>
  </ul>

<!-- Features -->

### Key Features <a name="key-features"></a>

- **Authentication API**
- **User management API**
- **Corporation management API**
- **Items management API**
- **Clients management API**
- **Orders management API**
- **Payments management API**
- **Stock management API**
- **Currencies management API**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LIVE DEMO -->

## 🚀 Live Demo <a name="live-demo"></a>

- Live demo is hosted in (Will be here soon)


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>


To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need the following installed in your local machine:

<ul>
<li>Ruby</li>
<li>Rails</li>
<li>PostgreSQL</li>
<li>Github Account</li>
</ul>

### Setup

Clone this repository to your desired folder:

```sh
  cd <desired-folder>
  git clone git@github.com:anthonymr/releveca-backend.git
  cd releveca-backend
```

### Install

Install this project with:

```sh
  bundle install
```

The above command installs necessary gems used in the project

Make sure you have the right PosgreSQL configuration in the [database config](./config/database.yml) file

Create database with this commmand:

```sh
  rails db:create
```

Seed your database with this command ([see seed file](./db/seeds.rb)):

```sh
  rails db:seed
```

### Usage

To run the project, execute the following command:

```sh
  rails s
```

The above command starts the rails server.

### Run tests

To run tests, run the following command:

```sh
  rspec spec
```

we have added Rspec test cases for all models and API endpoints in the project.

### Deployment

You can run server production mode with this command:

```sh

  RAILS_ENV=production rails s

```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Author <a name="authors"></a>


👤 **Anthony Martin**

- GitHub: [@anthonymr](https://github.com/anthonymr)
- Twitter: [@Anthony2Martin](https://twitter.com/Anthony2Martin)
- LinkedIn: [Anthony Martin](https://www.linkedin.com/in/anthony-martin-rodriguez/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FUTURE FEATURES -->

## 🔭 Future Features <a name="future-features"></a>

- [ ] **Bult piments API endpoints**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Please log any bugs or issues in [issues page](https://github.com/anthonymr/releveca-backend/issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>

If you like this project, please give a Star to the [github repo](https://github.com/anthonymr/releveca-backend)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>