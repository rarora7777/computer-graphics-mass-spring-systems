# Vectors and Matrices
sed -i 's/\\A\([^A-Za-z]\)/\\mathbf\{A\}\1/g' $1
sed -i 's/\\B\([^A-Za-z]\)/\\mathbf\{B\}\1/g' $1
sed -i 's/\\C\([^A-Za-z]\)/\\mathbf\{C\}\1/g' $1
sed -i 's/\\D\([^A-Za-z]\)/\\mathbf\{D\}\1/g' $1
sed -i 's/\\E\([^A-Za-z]\)/\\mathbf\{E\}\1/g' $1
sed -i 's/\\F\([^A-Za-z]\)/\\mathbf\{F\}\1/g' $1
sed -i 's/\\G\([^A-Za-z]\)/\\mathbf\{G\}\1/g' $1
sed -i 's/\\H\([^A-Za-z]\)/\\mathbf\{H\}\1/g' $1
sed -i 's/\\I\([^A-Za-z]\)/\\mathbf\{I\}\1/g' $1
sed -i 's/\\J\([^A-Za-z]\)/\\mathbf\{J\}\1/g' $1
sed -i 's/\\K\([^A-Za-z]\)/\\mathbf\{K\}\1/g' $1
sed -i 's/\\L\([^A-Za-z]\)/\\mathbf\{L\}\1/g' $1
sed -i 's/\\M\([^A-Za-z]\)/\\mathbf\{M\}\1/g' $1
sed -i 's/\\N\([^A-Za-z]\)/\\mathbf\{N\}\1/g' $1
sed -i 's/\\One\([^A-Za-z]\)/\\mathbf\{1\}\1/g' $1
sed -i 's/\\P\([^A-Za-z]\)/\\mathbf\{P\}\1/g' $1
sed -i 's/\\Q\([^A-Za-z]\)/\\mathbf\{Q\}\1/g' $1
sed -i 's/\\R\([^A-Za-z]\)/\\mathbf\{R\}\1/g' $1
sed -i 's/\\S\([^A-Za-z]\)/\\mathbf\{S\}\1/g' $1
sed -i 's/\\T\([^A-Za-z]\)/\\mathbf\{T\}\1/g' $1
sed -i 's/\\U\([^A-Za-z]\)/\\mathbf\{U\}\1/g' $1
sed -i 's/\\V\([^A-Za-z]\)/\\mathbf\{V\}\1/g' $1
sed -i 's/\\W\([^A-Za-z]\)/\\mathbf\{W\}\1/g' $1
sed -i 's/\\X\([^A-Za-z]\)/\\mathbf\{X\}\1/g' $1
sed -i 's/\\Y\([^A-Za-z]\)/\\mathbf\{Y\}\1/g' $1
sed -i 's/\\a\([^A-Za-z]\)/\\mathbf\{a\}\1/g' $1
sed -i 's/\\b\([^A-Za-z]\)/\\mathbf\{b\}\1/g' $1
sed -i 's/\\c\([^A-Za-z]\)/\\mathbf\{c\}\1/g' $1
sed -i 's/\\d\([^A-Za-z]\)/\\mathbf\{d\}\1/g' $1
sed -i 's/\\e\([^A-Za-z]\)/\\mathbf\{e\}\1/g' $1
sed -i 's/\\f\([^A-Za-z]\)/\\mathbf\{f\}\1/g' $1
sed -i 's/\\g\([^A-Za-z]\)/\\mathbf\{g\}\1/g' $1
sed -i 's/\\h\([^A-Za-z]\)/\\mathbf\{h\}\1/g' $1
sed -i 's/\\i\([^A-Za-z]\)/\\mathbf\{i\}\1/g' $1
sed -i 's/\\j\([^A-Za-z]\)/\\mathbf\{j\}\1/g' $1
sed -i 's/\\k\([^A-Za-z]\)/\\mathbf\{k\}\1/g' $1
sed -i 's/\\l\([^A-Za-z]\)/\\mathbf\{l\}\1/g' $1
sed -i 's/\\m\([^A-Za-z]\)/\\mathbf\{m\}\1/g' $1
sed -i 's/\\n\([^A-Za-z]\)/\\mathbf\{n\}\1/g' $1
sed -i 's/\\p\([^A-Za-z]\)/\\mathbf\{p\}\1/g' $1
sed -i 's/\\q\([^A-Za-z]\)/\\mathbf\{q\}\1/g' $1
sed -i 's/\\r\([^A-Za-z]\)/\\mathbf\{r\}\1/g' $1
sed -i 's/\\s\([^A-Za-z]\)/\\mathbf\{s\}\1/g' $1
sed -i 's/\\t\([^A-Za-z]\)/\\mathbf\{t\}\1/g' $1
sed -i 's/\\u\([^A-Za-z]\)/\\mathbf\{u\}\1/g' $1
sed -i 's/\\v\([^A-Za-z]\)/\\mathbf\{v\}\1/g' $1
sed -i 's/\\x\([^A-Za-z]\)/\\mathbf\{x\}\1/g' $1
sed -i 's/\\y\([^A-Za-z]\)/\\mathbf\{y\}\1/g' $1
sed -i 's/\\z\([^A-Za-z]\)/\\mathbf\{z\}\1/g' $1
sed -i 's/\\0\([^A-Za-z]\)/\\mathbf\{0\}\1/g' $1
sed -i 's/\\vec\([^A-Za-z]\)/\\mathbf\1/g' $1

#Operators
sed -i 's/\\mat\([^A-Za-z]\)/\\mathbf\1/g' $1
sed -i 's/\\min\([^A-Za-z]\)/\\mathop\{\\text\{min\}\}\1/g' $1
sed -i 's/\\argmax\([^A-Za-z]\)/\\mathop\{\\text\{argmax\}\}\1/g' $1
sed -i 's/\\argmin\([^A-Za-z]\)/\\mathop\{\\text\{argmin\}\}\1/g' $1
sed -i 's/\\transpose\([^A-Za-z]\)/\{\\mathsf T\}\1/g' $1
sed -i 's/\\tr\([^A-Za-z]\)/\\mathop\{\\text\{tr\}\}\1/g' $1

#Special characters
sed -i 's/∈/\\in /g' $1
sed -i 's/³/\^3 /g' $1
sed -i 's/½/\\frac12 /g' $1
sed -i 's/∂/\\partial /g' $1
sed -i 's/∆/\\Delta /g' $1
sed -i 's/²/\^2 /g' $1
sed -i 's/‖/\\| /g' $1
sed -i 's/↔/\\Leftrightarrow /g' $1
sed -i 's/→/\\Rightarrow /g' $1
sed -i 's/∀/\\forall /g' $1
sed -i 's/θ/\theta /g' $1
sed -i 's/Θ/\Theta /g' $1
sed -i 's/₁/\_1 /g' $1
sed -i 's/₂/\_2 /g' $1
sed -i 's/₃/\_3 /g' $1
sed -i 's/φ/\\varphi /g' $1
sed -i 's/°/\^\\circ /g' $1
sed -i 's/←/\\Leftarrow /g' $1
sed -i 's/σ/\\sigma /g' $1
sed -i 's/⁰/\^0 /g' $1
sed -i 's/δ/\\delta /g' $1
sed -i 's/ε/\\epsilon /g' $1
sed -i 's/≈/\\approx /g' $1
sed -i 's/∑/\\Sigma /g' $1
sed -i 's/∞/\\infty /g' $1
sed -i 's/Σ/\\sigma /g' $1
sed -i 's/Ω/\\Omega /g' $1
sed -i 's/π/\\pi /g' $1
sed -i 's/ψ/\\psi /g' $1
sed -i 's/≠/\\ne /g' $1
sed -i 's/∫/\\int /g' $1
sed -i 's/∆/\\Delta /g' $1
sed -i 's/∆/\\Delta /g' $1
sed -i 's/±/\\pm /g' $1
sed -i 's/≥/\\ge /g' $1
sed -i 's/≤/\\le /g' $1
sed -i 's/×/\\times /g' $1
#sed -i 's///g' $1

# Alec's escaped chars
sed -i 's/\\\_/\_/g' $1
sed -i 's/\\\^/\^/g' $1

# Misc.
sed -i 's/\\hat\([^A-Za-z]\)/\\widehat\1/g' $1