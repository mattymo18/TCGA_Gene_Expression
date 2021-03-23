FROM rocker/verse
MAINTAINER Matt Johnson <Johnson.Matt1818@gmail.com>
RUN R -e "install.packages('gridExtra')"
RUN R -e "install.packages('ggrepel')"
RUN R -e "install.packages('cluster')"
RUN R -e "install.packages('factoextra')"
RUN R -e "install.packages('class')"
RUN R -e "install.packages('knitr')"
RUN R -e "install.packages('kableExtra')"
RUN R -e "install.packages('webshot')"
