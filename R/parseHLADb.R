parseHLADb <-function (hlaDbPath)
{    # GOAL: load information from HLA database and create a usable R object that contains it
    # Input validation:
    #     must be valid database path
    # minimum expected files must be present

    db <- data.frame

    options(stringsAsFactors = FALSE)
    library (stringr)
    library (dplyr)

     #check if RData file is present
    folderName <- dirname(hlaDbPath);
    rdaFileName <-paste(folderName,'hladb.Rdata', sep = '/')
    if (!file.exists(rdaFileName))
    {
    fileName <- paste(folderName, 'E_GEUVexp.txt',sep = '/')
    file.exists(fileName)
    data <- read.table(fileName, header = TRUE, stringsAsFactors = FALSE)
    rownames(data) <- data[,1]
    data <- data[,2:ncol(data)]

    tData <- t(data)
    rNames <- rownames(tData)
    #split alleles numbers from gene name
    nameList <- rep(str_split(rNames, '_'), times = ncol(tData))
    sampleNames <- rep(colnames(tData), each = nrow(tData))
    geneNames <-matrix(unlist(nameList),  ncol = 2,byrow=T)
    colName <-c('SampleName', 'AlleleName', 'GeneName', 'AlleleGroup','Protein', 'SynSubst','NonCoding','Suffix')

     #split the hla digits
    typing <-matrix(unlist(lapply(tData, splitTyping)),ncol = 6, byrow =T)
    db <- data.frame(cbind(matrix(sampleNames), geneNames[,2],typing))
    colnames(db)<-colName

    #create HlADb class
    hla <-setClass('HLADb',
                  contains = c("data.frame","list")                  )
    db<-hla(db)
    save(db, file= rdaFileName)

    }else
    {
        db <-load(rdaFileName)
    }
    return (db)
#
}