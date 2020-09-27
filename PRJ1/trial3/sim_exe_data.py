# aggregate simulated data
# by teej

# import packages
import pandas as pd

# main function
def main(infile, outfile, method):
    # define variables
    sign_on() # primpt to console signature
    print("Running " + method + "...")
    # infile = "rt_hya.out"
    # outfile = "rt_hya.csv"
    
    clean_file(infile, outfile) # clean out the header and footer of file

    # read in data
    print("Reading in data...")
    df = pd.read_csv(outfile, header=None) # import as dataframe
    df.columns = ['inst', 'btype', 'result'] # rename columns
    print(df.head())

    # get bin count
    print("Aggregating Data...")
    bins = [0, 19, 199, 1999, 99999999999] # set variables
    df_tot = df.pivot_table(values='result', index='inst', aggfunc='count') # find the total
    df_tot['bin'] = pd.cut(df_tot['result'], bins=bins) # add bins
    df_miss = df[df['result'] == ' MissPrediction '].pivot_table(values='result', index='inst', aggfunc='count')
    s = pd.cut(df_tot['result'], bins=bins).value_counts()
    print(s)

    # merge data
    print("Merging Data...")
    df = pd.merge(df_tot, df_miss, how='left', on='inst') # merge to have final results
    df['result_y'] = df['result_y'].fillna(0) # elminate NaNs

    # output final results
    print("Building final table...")
    df = df.pivot_table(values=['result_y', 'result_x'], index='bin', aggfunc='sum')
    df['result_z'] = (df['result_x'] - df['result_y'])/df['result_x']
    
    # print out data sets
    # print(df_tot.count)
    # print(df_miss.count)
    print(df)

    # the end
    sign_off() # prompt to console signature


# tool box below
def clean_file(inpath, outpath):
    print("Cleaning " + inpath + "...")
    with open(inpath, "r") as infile:
        with open(outpath, "w") as outfile:
            for line in infile:
                if line[0:2] == "0x":
                    outfile.write(line)
    print("Success output: " + outpath)

def sign_on():
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    print("~~~~~~~ RUNNING SIMULATION ~~~~~~~~")
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    print()

def sign_off():
    print()
    print("~~~~~~~~~~~~ COMPLETE! ~~~~~~~~~~~~")
# end of toolbox

# exeucte code here
main("rt_hya.out", "rt_hya.csv", "Hybrid")
main("rt_nta.out", "rt_nta.csv", "NotTaken")
# end of execution
