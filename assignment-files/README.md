# Eddy Assignment

## Introduction

The goal of this assignment is to develop a small web application for a label that needs to manage some artist information and compute statements based on a sales report.

## Assignment

### Context

We provide some JSON files to seed your database:
- tracks.json
- sales-report.json

In the `sales-report.json` you can find the revenue for every album and tracks.

For each transaction type below, the artist is owed a specific royalty rate:

| Transaction Type                    | Rate |
|-------------------------------------|------|
| Download Albums                     | 30%  |
| Subscription Audio Streams          | 50%  |
| Ad-Supported Audio Streams          | 50%  |
| Non-interactive Radio               | 50%  |
| Cloud Match Units                   | 50%  |
| Mid-Tier Subscription Audio Streams | 50%  |
| Physical Sales                      | 15%  |
| Download Tracks                     | 30%  |

Transaction types can be grouped as:
- **Track sales** are all streaming type / cloud match units / download track.
- **Release sales** are physical sales & download albums.

**"Label Share Net Receipts" is the one that should be used for revenues**.

**"Product code" usually corresponds to the ISRC, but when it's a release sale, it corresponds to the UPC**.

### Models
For this assignment, you will need to create four models:

- Artists (name)
- Albums (artist, UPC[^1], release title, year)
- Tracks (album, ISRC[^2], track name)
- Sales (track/album, transaction type, revenue for the label, revenue for the artist)

Feel free to change the models the best way you see fit.

### Task

1. Create a view where you can select an artist and a year, and show all filtered tracks.
2. Import the JSON sales report to the sales table and assign the revenue for artists and labels according to the royalty rate table (you can do this during the seeding)
3. Create a view with a summary of the revenue by each artist, with the following information:
   * Artist name
   * Total statement income (artist share + label share)
   * Total artist share
   * Total label share
   * (Optional) Artist share grouped by track sales
   * (Optional) Artist share grouped by release sales

### Not necessary
Because of the limited time, here are some things you don't have to do:

- Authentication or authorization
- We'll check it on desktop, so responsiveness isn't necessary

### Notes
- You can use any framework in Ruby or Javascript: Ruby on Rails, React, Vue.js, etc.
- You can use any CSS framework: Semantic UI, Element UI, Ant Design, Tailwind CSS, etc.
- We prefer quality over quantity ;)

[^1]: https://en.wikipedia.org/wiki/Universal_Product_Code
[^2]: https://en.wikipedia.org/wiki/International_Standard_Recording_Code
