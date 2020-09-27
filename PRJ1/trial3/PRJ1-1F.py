# CPI = 1 + (%ofBranches)(%Misspredicted)(Penalty)
# by teej

def calc_pen(cycles, perMake):
    # init variables
    inst = 274830159
    penalty = 1
    perBranch = .1110
    perMiss = 1-perMake

    # calc cpi
    cpi = cycles/inst
    den = perMiss*perBranch
    penalty = (cpi-1)/den

    # log stuff
    print("CPI: " + str(cpi))
    print("perMiss: " + str(perMiss))
    print("perBranch: " + str(perBranch))
    print()
    print("penalty: " + str(penalty))
    print("~~~~~~~")
    print()

    return((cpi-1)/den)

# execute code here
calc_pen(401805271, .4878)
calc_pen(295221042, .8555)
calc_pen(278626125, .8932)
