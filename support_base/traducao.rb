class Traducao
    include Capybara::DSL
    include RSpec::Matchers

    def traducaoString(idioma, string,filtro)
        @espanhol = {
            sucesso: [ 
                'Las informaciones fueron guardadas con éxito',
                'Registro eliminado con éxito',
                'Exito',
                'Punto del referencia registrado con éxito',
            ],
            erro:[
                'Existen pendientes en el formulario, por favor, revise los datos de la 1° o 3° pestaña',
                'Ha ocurrido un error en el sistema, intente nuevamente ',
            ],
            alerta: [
                'Ningún perfil ha sido seleccionado, por lo que no es posible configurar para acceder al sistema',
                'Registros excluidos no pueden ser recuperados',
                'Es necesario seleccionar un registro',
                'Usted debe seleccionar un registro en la cuadrícula',
                'Desea realmente cancelar la operación ?',
                'Para realizar la eliminación es necesario resolver el/los ítem(s) debajo',
            ]
        }
        @ingles = {
            sucesso: [ 
                'The information was successfully saved',
                'Record deleted successfully',
                'Success',
                'Point reference registered successfully',
            ],
            erro:[
                'There are pending on the form, please check the data of the 1st or 3rd tab',
                'Ocurred one error in the system plis try again',
            ],
            alerta: [
                'No profile has been selected, so it was not possible to configure to access the system',
                'Excluded records can not be recovered',
                'You must select a record',
                'You must select a record in the Grid',
                'Do you really want to cancel the operation?',
                'To perform the deletion it is necessary above the resolvers',
            ]
        }
    
        @portugues = {
            sucesso: [ 
                'As informações foram salvas com sucesso',
                'Registro deletado com sucesso',
                'Sucesso',
                'Ponto de referência cadastrado com sucesso'
            ],
            erro:[
                'Existem pendências no formulário, por favor, verifique os dados da 1º ou 3º aba.',
                'Ocorreu um erro no sistema, tente novamente !',
            ],
            alerta: [
                'Nenhum perfil foi selecionado, portanto, não foi possível realizar a configuração para acesso ao sistema !',
                'Registros excluidos não podem ser recuperados',
                'É preciso selecionar um registro',
                'Deseja realmente cancelar a operação ?',
                'Para realizar a exclusão, é necessário resolver o(s) item(ns) abaixo',
            ]
        }

        if idioma == 1
            return (@portugues[:"#{filtro}"].include?(string)) ? string : false
        elsif idioma == 2
            return (@ingles[:"#{filtro}"].include?(string)) ? string : false
        else
            return (@espanhol[:"#{filtro}"].include?(string)) ? string : false
        end       
    end
end