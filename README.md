
<p align='center'>
  <a href='https://unico.io'>
    <img width='350' src='https://unico.io/wp-content/uploads/2024/05/idcloud-horizontal-color.svg'></img>
  </a>
</p>

<h1 align='center'> CBU - WEBVIEW - IOS</h1>

<div align='center'>
  
  ### POC de implementação do By Unico em IOS
  
 
</div>

## 💻 Compatibilidade

### Versões mínimas

- Possuir a versão 15.0.1 ou superior do Xcode instalado (IDE oficial de desenvolvimento da Apple);

### Dispositivos compatíveis

- O componente de captura disponibilizado por meio do SDK iOS é compatível com todos os dispositivos que possuam iOS 11 ou versões mais recentes.


## ✨ Como começar

Para utilizar o by Unico por meio do SDK do by Unico, o primeiro passo é cadastrar os domínios que serão utilizados como host para exibir o iFrame da jornada do usuário no by Unico.

Sinalize o responsável pelo seu projeto de integração ou o time de suporte da Unico para realizar essa configuração.

Para começar a usar o SDK, é necessário realizar a instalação do SDK Web da Unico. Vale destacar que o "by Unico" utiliza o mesmo SDK empregado no IDPay.:

$ npm install idpay-b2b-sdk@0.0.27 ou no caso dessa POC apenas o npm install

Para conseguir executa-la é necessario ter uma conta de servico na Unico e um ambiente de testes cadastrado pelo seu gerente de projetos para que voce consiga criar um processo, após isso ao criar um processo voce irá recebe um ID de processo e um Token no response.

Com essas informacoes voce deve passar dentro dos métodos Init e Open conforme abaixo e depois executar o npm start para iniciar a POC.

Feito isso deve criar no botao de Init para iniciar a autenticacao e depois no Open para abrir o processo e inciar o fluxo By Unico.


## ✨ Metodos disponiveis

init(options)
Esse método inicializa o SDK, fazendo um pré-carregamento de assets, criando a experiência mais fluida para o usuário final. Nesse momento é preciso enviar o token recebido como resultado do CreateProcess.

<strong>Parâmetros:</strong>

options - é um objeto com as seguintes propriedades de configuração:

<strong>type</strong>

### O tipo de fluxo que será inicializado. No by Unico utilizamos a opção "IFRAME".

<strong>token</strong>

### Recebe o token do processo criado. Esse token é importante para conseguirmos autenticar a jornada e garantir que somente domínios autorizados utilizem-na (pode ser obtido na criação do processo via API).

```javascript
import { IDPaySDK } from “idpay-b2b-sdk”;

IDPaySDK.init({
  type: 'IFRAME',
  env: 'uat'// Só irá ser preenchido se for ambiente de testes.
  token,
});
```

---

<strong>open(options)</strong>
### Esse método realiza a abertura da experiência do by Unico. Para o fluxo do tipo IFRAME, essa função exibe o iframe já pré-carregado, e inicia o fluxo de mensageria entre a página do cliente e a experiência do by Unico.

## Parâmetros:

<strong>options</strong> - é um objeto com propriedades de configuração:

<strong>processId</strong>

### Recebe o ID do processo criado. Esse ID é importante para conseguirmos obter os detalhes do processo e realizarmos todo o fluxo da maneira correta (pode ser obtido na criação do processo via API).

<strong>token</strong>

### Recebe o token do processo criado. Esse token é importante para conseguirmos autenticar a jornada e garantir que somente domínios autorizados utilizem-na (pode ser obtido na criação do processo via API).

<strong>onFinish(process)</strong>

### Recebe uma função de callback que será executada no término da jornada do by Unico, passando como argumento o objeto do processo com os seguintes dados: { captureConcluded, concluded, id }

```javascript
const processId = '9bc22bac-1e64-49a5-94d6-9e4f8ec9a1bf';
```

```javascript
const process = {
  id: '9bc22bac-1e64-49a5-94d6-9e4f8ec9a1bf',
  concluded: true,
  captureConcluded: true
};
```

```javascript
const onFinishCallback = process => {
  console.log('Process', process);
}
```

```javascript
IDPaySDK.open({
  transactionId: processId,
  token: token,
  onFinish: onFinishCallback
});
```

---

## ✨ Link da nossa documentacao: 

https://devcenter.unico.io/idcloud/integracao/integracao-by-unico/controlando-a-experiencia/sdk#como-comecar






# unico-cbu-ios
Essa POC visa exemplificar a implementação de uma Webview em uma aplicação IOS para uso do By Unico

## Sobre a POC
A POC utiliza o SFSafariViewController para a camada da Webview, pois essa classe apresenta recursos melhores para interação de páginas Web

## Adições necessárias ao info.plist
<img width="831" alt="image" src="https://user-images.githubusercontent.com/99362225/194593507-28709da4-a877-4446-9d7c-6513decd7297.png">

## Sobre o SDK
Para mais detalhes sobre veja nossa [Documentação Oficial](https://devcenter.unico.io/idcloud/integracao/integracao-by-unico/controlando-a-experiencia/redirecionando-o-usuario)

## Referências
https://developer.apple.com/news/?id=trjs0tcd<br>
https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller
