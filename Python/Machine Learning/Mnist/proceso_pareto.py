

def proceso_pareto(precision, recall):

    import matplotlib.pyplot as plt
    import numpy as np

    def OptimalidadPareto(Medi):
        Valores_eficientes = np.ones(Medi.shape[0],dtype=bool)
        for i , c in enumerate (Medi):
            if Valores_eficientes[i]:
                Valores_eficientes[Valores_eficientes] = np.any(Medi[Valores_eficientes]>c, axis=1)
                Valores_eficientes[i] = True
        return Valores_eficientes
    
    def GraficadoFrentePareto(Medi, color_pareto):
        Val_Eficientes = OptimalidadPareto(Medi)

        plt.scatter(Medi[:,1], Medi[:,0], color='gray')
        plt.scatter(Medi[Val_Eficientes,1], Medi[Val_Eficientes,0], color=color_pareto)
        plt.xlabel('Precision')
        plt.ylabel('Recall')
        plt.title('Frente de Pareto')
        
    precision=np.array(precision).flatten()
    recall=np.array(recall).flatten()
    Mediciones = np.transpose(np.array([precision, recall]))

    GraficadoFrentePareto(Mediciones, color_pareto='red')
    Val_eficientes=OptimalidadPareto(Mediciones)
    print(Val_eficientes)
    plt.show()
    return(Val_eficientes) 