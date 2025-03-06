# Coming from Python, moving to R:

### 

- Python starts at 0, R at 1.
- [Docstrings](https://cran.r-project.org/web/packages/docstring/vignettes/docstring_intro.html) are not a standard thing in R.


### Syntax differences

| Python | R |
| :-------------: |:-------------:|
| index | rownames |
| nunique() | n_distinct() | 
| min(), max() | range() |
| len() | length() |
| Path('/dir/') | file.something('dir/') |
| range(10) | c(0:9) | 
| type() | class() or typeof() |

**IMPORTANT NOTES:**
- In `c(1:10)` R starts at 1 incl. 10, while Pythons `range(10)` starts counting from 0 till 10 (generating 10 integers).
- `group_by()` incl. a group member `NA` if it is in grouping column. (This is excl. in Python)
- `distinct()` in R will include `NA`, use arg. `na.rm = TRUE` to exclude it. (This is excl. in Python unique.)
- To give a column to a function, use {{column}} in de function to actually call it.
