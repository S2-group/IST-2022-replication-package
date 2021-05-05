# ease-2021-replication-package
This repository contains the replication package of the paper **Measurement-based Experiments on the Mobile Web: A Systematic Mapping Study**, published at the International Conference on Evaluation and Assessment in Software Engineering (EASE 2021). 

This study has been designed, developed and reported by the folllowing investigators:
- [Ivano Malavolta](https://www.ivanomalavolta.com) (Vrije Universiteit Amsterdam)
- [Omar de Munk](https://www.linkedin.com/in/omar-de-munk-1ba555116/?originalSubdomain=nl) (Vrije Universiteit Amsterdam)

For any information, interested researchers can contact us by sending an email to any of the investigators listed above. 

## Structure of the replication package
This replication package is organized according to the following structure:
```
├── README.md: The file you are reading right now.
├── LICENSE: File describing under which license the content of this repository is being made available.
├── data
│   ├── extracted_data
│   │   ├── extracted_data.csv: CSV file containing the extracted data from all 28 primary studies based on our designed comparison framework.
│   │   └── extracted_data.xlsx: Same content as the CSV file above but with XLSX formatting intact to improve readability.
│   └── paper_selection
│       ├── paper_selection.csv: CSV file containing the results of the search & selection phase (640 evaluated papers).
│       └── paper_selection.xlsx: Same content as the CSV file above but with XLSX formatting intact to improve readability.
└── scripts
    └── plots.ipynb: Jupyter Notebook file containing the Python code used to analyze the extracted data and generate the resulting plots.
```

## How to cite this replication package
If the data or software contained in this replication package is helping your research, consider to cite it is as follows, thanks!

```
@inproceedings{EASE_2021,
  title={{Measurement-based Experiments on the Mobile Web: A Systematic Mapping Study}},
  author={Omar {de Munk} and Ivano Malavolta},
  booktitle={Proceedings of the International Conference on Evaluation and Assessment on Software Engineering (EASE)},
  pages={To appear},
  publisher={ACM},
  year={2021},
  url = {http://www.ivanomalavolta.com/files/papers/EASE_2021.pdf}
}
```
