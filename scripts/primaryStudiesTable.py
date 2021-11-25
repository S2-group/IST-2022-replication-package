# %% Imports

import csv
from jinja2 import Template
import pandas as pd

# %% Files

data = pd.read_excel("../data/extracted_data.xlsx")

# %% Template

template = Template(
"""{\\tiny 
\\begin{longtable}[htbp]{| p{.05\\textwidth} | p{.6\\textwidth} |  p{.3\\textwidth} |  p{.05\\textwidth} |} \\hline 
{\\bf ID} & {\\bf Title} & {\\bf Authors} & {\\bf Year} \\\\ \\hline
{% for key,value in papers.iterrows() -%}
	{{value['PID']}} & {{value['Title']}} &  & {{value['Year']}} \\\\ \\hline
{% endfor %}
\\caption{ Primary Studies} 
\\label{tab:primarystudies}
\\end{longtable}}""")

# %% Run

out_file = open("Appendix.primary.studies.tex", "w")
out_file.write(template.render(papers=data))
out_file.flush()
out_file.close()

# %%
