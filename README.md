# IST-2022-replication-package
This repository contains the replication package of the paper **The State of the Art in Measurement-based
Experiments on the Mobile Web**.

This study has been designed, developed and reported by the folllowing investigators:
- [Ivano Malavolta](https://www.ivanomalavolta.com) (Vrije Universiteit Amsterdam)
- [Gian Luca Scoccia](https://www.gianlucascoccia.github.com) (University of L'Aquila)
- [Omar de Munk](https://www.linkedin.com/in/omar-de-munk-1ba555116/?originalSubdomain=nl) (Vrije Universiteit Amsterdam)

For any information, interested researchers can contact us by sending an email to any of the investigators listed above. 

## Structure of the replication package
This replication package is organized according to the following structure:
```
├── README.md: The file you are reading right now.
├── LICENSE: File describing under which license the content of this repository is being made available.
├── data
│   ├── extracted_data
│   │   ├── extracted_data.csv: CSV file containing the extracted data from all 33 primary studies based on our designed comparison framework.
│   │   └── extracted_data.xlsx: Same content as the CSV file above but with XLSX formatting intact to improve readability.
│   └── paper_selection
│       ├── paper_selection.csv: CSV file containing the results of the search & selection phase (786 evaluated papers).
│       └── paper_selection.xlsx: Same content as the CSV file above but with XLSX formatting intact to improve readability.
└── scripts
    └── plots.ipynb: Jupyter Notebook file containing the Python code used to analyze the extracted data and generate the resulting plots.
    └── [PlotName].R: R script to generate the PlotName included in the paper. 
```
