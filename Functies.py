def sliding_window(DataSet):
    """
    Maak van een dataset een patroon via het sliding window principe:
    
    Voor elke array in de data set:
      - bepaal de lengte van de array. Het aantal windows is gelijk aan de lengte van de array -2
        (anders loopt de window over het einde van de array met fout melding als gevolg)
      - vul een window van 3x3 en maak hier een vector van (sla het window plat met hstack).
      - schrijf deze vector weg in de nieuwe dataset
    Schrijf elke nieuwe array weg in de nieuwe dataset


    In: Dataset opgebouwd uit een array van arrays

    Out: Dataset bestaande uit een array met vectoren.
    """

    DataOut=[]
    for InArray in DataSet:
        lengteArray = InArray.shape[0]
        for regelNr in range(lengteArray-2):
            window = (np.hstack((InArray[regelNr],InArray[regelNr+1],InArray[regelNr+2])).tolist())
            DataOut.append(window)
    return np.array(DataOut)

def discretiminator(Dataset,noClusters,Labels):
    """
    Maak van een dataset, aantal clusters en labels een matrix in de vorm van
    lengte dataset x aantal clusters.
    
    Tel vervolgens hoe vaak een aantal clusters per rij voorkomt door 1 op te tellen 
    bij de index die overeenkomt met het cluster (dus als het label de waarde 0 heeft 
    moet er 1 opgeteld worden bij kolom 0. Dus het cluster zelf bepaald bij 
    welke kolom er een wordt opgeteld. Als de lengte van een array uit X_train afgelopen 
    is wordt een volgende rij gemaakt

    In: 
    - Dataset opgebouwd uit een array van arrays. Voor deze case is dit X_train
    - noClusters clusters die in de KMeans is gebruikt en bepaald aantal kolommen van de DataOut
    - Labels bepaald met KMeans

    Out: Dataset bestaande uit een array met vectoren.
    """

    DataOut=np.zeros((len(Dataset),noClusters))
    teller = 0
    for idx,array in enumerate(Dataset):
        for i in range(array.shape[0]-2):
            DataOut[idx,Labels[teller]]+=1
            teller+=1
    return(DataOut)