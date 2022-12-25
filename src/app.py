import warnings

warnings.filterwarnings("ignore", category=FutureWarning)
from flask import abort, render_template, Flask
import logging
import db

APP = Flask(__name__)


# Start page
@APP.route('/')
def index():
	# TODO
	stats = {}
	x = db.execute('SELECT COUNT(*) AS recintos FROM RECINTO').fetchone()
	stats.update(x)
	x = db.execute('SELECT COUNT(*) AS animais FROM ANIMAL').fetchone()
	stats.update(x)
	x = db.execute('SELECT COUNT(*) AS funcionarios FROM FUNCIONARIO').fetchone()
	stats.update(x)
	logging.info(stats)
	return render_template('index.html', stats=stats)


# Initialize db
# It assumes a script called db.sql is stored in the sql folder
@APP.route('/init/')
def init():
	return render_template('init.html', init=db.init())


# RECINTOS
@APP.route('/recintos/')
def list_recintos():
	recintos = db.execute('''
		SELECT R.CodRec, R.Nome, R.Tamanho, R.DataCons, COUNT(A.CodAnimal) Contagem
		FROM RECINTO R LEFT JOIN ANIMAL A USING(CodRec)
		GROUP BY R.CodRec
		ORDER BY Nome
	''').fetchall()
	return render_template('recinto-list.html', recintos=recintos)


@APP.route('/recintos/<int:id>/')
def get_recinto(id):
	recinto = db.execute('''
		SELECT CodRec, Nome, Tamanho, DataCons
		FROM RECINTO
		WHERE CodRec = %s
		''', id).fetchone()

	if recinto is None:
		abort(404, 'Recinto id {} does not exist.'.format(id))

	animais = db.execute('''
		SELECT CodAnimal, A.Nome as NomeAnimal, Especie
		FROM ANIMAL A JOIN RECINTO USING(CodRec)
		WHERE CodRec = %s
		ORDER BY Especie
		''', id).fetchall()

	funcionarios = db.execute('''
		SELECT CodFunc, F.Nome as NomeFunc
		FROM TRABALHA_EM JOIN RECINTO USING(CodRec) JOIN FUNCIONARIO F USING(CodFunc)
		WHERE CodRec = %s
		ORDER BY NomeFunc
		''', id).fetchall()

	return render_template(
		'recinto.html',
		recinto=recinto,
		animais=animais,
		funcionarios=funcionarios
	)


@APP.route('/recintos/search/<expr>/')
def search_recinto(expr):
	search = {'expr': expr}
	expr = '%' + expr + '%'
	recintos = db.execute('''
		SELECT CodRec, Nome
		FROM RECINTO
		WHERE Nome LIKE %s
		ORDER BY Nome
		''', expr).fetchall()
	return render_template('recinto-search.html',
	                       search=search,
	                       recintos=recintos)


@APP.route('/recintos/searche/<expr>/')
def searche_recinto(expr):
	search = {'expr': expr}
	expr = '%' + expr + '%'
	recintos = db.execute('''
		SELECT DISTINCT CodRec, R.Nome
		FROM RECINTO R JOIN ANIMAL A USING(CodRec)
		WHERE A.Especie LIKE %s
		ORDER BY R.Nome
		''', expr).fetchall()
	return render_template('recinto-search.html',
	                       search=search, recintos=recintos)


# ANIMAIS
@APP.route('/animais/')
def list_animais():
	animais = db.execute('''
	  SELECT CodAnimal, Nome, Especie
	  FROM ANIMAL
	  ORDER BY Especie
	''').fetchall()
	return render_template('animal-list.html', animais=animais)


@APP.route('/animais/<int:id>/')
def get_animal(id):
	animal = db.execute('''
		SELECT CodAnimal, Nome, Especie, Sexo, Peso, DataAdmis, DataNasc, HabHumor, HabAtiv, ComidaFav, CodRec
		FROM  ANIMAL
		WHERE CodAnimal = %s
		''', id).fetchone()
	if animal is None:
		abort(404, 'Animal id {} does not exist.'.format(id))

	recinto = db.execute(
		'''
		SELECT CodRec, R.Nome as NomeRec
		FROM RECINTO R JOIN ANIMAL USING(CodRec)
		WHERE CodAnimal = %s
		ORDER BY NomeRec
		''', id).fetchone()

	return render_template('animal.html',
	                       animal=animal, recinto=recinto)


@APP.route('/animais/search/<expr>/')
def search_animal(expr):
	search = {'expr': expr}
	expr = '%' + expr + '%'
	animais = db.execute(
		''' 
		SELECT CodAnimal, Nome, Especie
		FROM ANIMAL 
		WHERE Especie LIKE %s
		ORDER BY Especie
		''', expr).fetchall()
	return render_template('animal-search.html',
	                       search=search, animais=animais)


# FUNCIONÁRIOS
@APP.route('/funcionarios/')
def list_funcionarios():
	funcionarios = db.execute('''
		SELECT F.CodFunc, F.Nome, F.Sexo, F.Email, COUNT(R.CodRec) as Contagem
		FROM  RECINTO R JOIN TRABALHA_EM USING(CodRec) RIGHT JOIN FUNCIONARIO F USING(CodFunc)
		GROUP BY F.CodFunc
		ORDER BY F.Nome
	''').fetchall()

	return render_template('funcionario-list.html', funcionarios=funcionarios)


@APP.route('/funcionarios/<int:id>/')
def get_funcionario(id):
	funcionario = db.execute(
		'''
		SELECT CodFunc, Nome, Sexo, Email, Orientador
		FROM  FUNCIONARIO
		WHERE CodFunc = %s
		''', id).fetchone()
	if funcionario is None:
		abort(404, 'Funcionário id {} does not exist.'.format(id))

	telefones = db.execute(
		'''
		SELECT NumTel
		FROM TELEFONE_FUNC
		WHERE CodFunc = %s
		''', id).fetchall()

	recintos = db.execute(
		'''
		SELECT RECINTO.CodRec, RECINTO.Nome
		FROM FUNCIONARIO JOIN TRABALHA_EM USING(CodFunc) JOIN RECINTO USING(CodRec)
		WHERE FUNCIONARIO.CodFunc = %s
		''', id).fetchall()

	return render_template('funcionario.html',
	                       funcionario=funcionario, telefones=telefones, recintos=recintos)


@APP.route('/funcionarios/search/<expr>/')
def search_funcionario(expr):
	search = {'expr': expr}
	expr = '%' + expr + '%'
	funcionarios = db.execute(
		''' 
		SELECT CodFunc, Nome
		FROM FUNCIONARIO 
		WHERE Nome LIKE %s
		ORDER BY Nome
		''', expr).fetchall()
	return render_template('funcionario-search.html',
	                       search=search, funcionarios=funcionarios)
