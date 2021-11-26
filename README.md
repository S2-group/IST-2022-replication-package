# IST-2022-replication-package
This repository contains the replication package of the paper **The State of the Art in Measurement-based Experiments on the Mobile Web**, published at the International Conference on Evaluation and Assessment in Software Engineering (EASE 2021). 

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

## How to cite this work
If the data or software contained in this replication package is helping your research, consider to cite it is as follows, thanks!

```
@inproceedings{IST_2022,
  title={{The State of the Art in Measurement-based Experiments on the Mobile Web}},
  author={Omar {de Munk}, Gian Luca Scoccia and Ivano Malavolta},
  journal={Information and Software Technology}
  pages={To appear},
  publisher={Elsevier},
  year={2022},
  url = {http://www.ivanomalavolta.com/files/papers/IST_2022.pdf}
}
```
